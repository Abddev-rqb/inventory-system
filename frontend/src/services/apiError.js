const DEFAULT_ERROR_MESSAGE =
  "Something went wrong. Please try again.";

export function parseApiError(error) {
  const status =
    error?.response?.status ??
    null;

  const responseData =
    error?.response?.data;

  if (!responseData) {
    return {
      status,
      message:
        error?.message ??
        DEFAULT_ERROR_MESSAGE,
      fields: {},
    };
  }

  if (
    typeof responseData ===
    "string"
  ) {
    return {
      status,
      message:
        responseData ||
        DEFAULT_ERROR_MESSAGE,
      fields: {},
    };
  }

  if (
    typeof responseData !==
      "object" ||
    Array.isArray(responseData)
  ) {
    return {
      status,
      message:
        DEFAULT_ERROR_MESSAGE,
      fields: {},
    };
  }

  const fields =
    extractFieldErrors(
      responseData,
    );

  const message =
    extractErrorMessage(
      responseData,
      fields,
    );

  return {
    status,
    message,
    fields,
  };
}

export async function parseBlobApiError(
  error,
) {
  const status =
    error?.response?.status ??
    null;

  const responseData =
    error?.response?.data;

  if (
    responseData instanceof Blob
  ) {
    try {
      const responseText =
        await responseData.text();

      if (!responseText) {
        return {
          status,
          message:
            "The Excel export could not be completed.",
          fields: {},
        };
      }

      const parsedData =
        JSON.parse(
          responseText,
        );

      const parsedError =
        parseApiError({
          response: {
            ...error.response,
            status,
            data: parsedData,
          },
        });

      return {
        ...parsedError,
        status,
      };
    } catch {
      return {
        status,
        message:
          "The Excel export could not be completed.",
        fields: {},
      };
    }
  }

  const parsedError =
    parseApiError(error);

  return {
    ...parsedError,
    status:
      parsedError.status ??
      status,
  };
}

export function getFirstFieldError(
  fields,
  preferredFieldNames = [],
) {
  if (
    !fields ||
    typeof fields !== "object" ||
    Array.isArray(fields)
  ) {
    return null;
  }

  for (
    const fieldName
    of preferredFieldNames
  ) {
    const messages =
      normalizeMessages(
        fields[fieldName],
      );

    const firstMessage =
      messages.find(Boolean);

    if (firstMessage) {
      return String(
        firstMessage,
      );
    }
  }

  for (
    const messages
    of Object.values(fields)
  ) {
    const normalizedMessages =
      normalizeMessages(
        messages,
      );

    const firstMessage =
      normalizedMessages.find(
        Boolean,
      );

    if (firstMessage) {
      return String(
        firstMessage,
      );
    }
  }

  return null;
}

function extractErrorMessage(
  responseData,
  fields,
) {
  const errorObject =
    responseData?.error &&
    typeof responseData.error ===
      "object" &&
    !Array.isArray(
      responseData.error,
    )
      ? responseData.error
      : responseData;

  const directMessage =
    errorObject?.message ??
    errorObject?.detail ??
    errorObject?.error ??
    errorObject?.non_field_errors;

  const normalizedDirectMessage =
    normalizeMessage(
      directMessage,
    );

  if (
    normalizedDirectMessage
  ) {
    return normalizedDirectMessage;
  }

  const firstFieldMessage =
    Object.values(fields)
      .flat()
      .find(Boolean);

  if (firstFieldMessage) {
    return String(
      firstFieldMessage,
    );
  }

  return DEFAULT_ERROR_MESSAGE;
}

function extractFieldErrors(
  responseData,
) {
  const errorObject =
    responseData?.error &&
    typeof responseData.error ===
      "object" &&
    !Array.isArray(
      responseData.error,
    )
      ? responseData.error
      : responseData;

  const fieldSource =
    errorObject?.details &&
    typeof errorObject.details ===
      "object" &&
    !Array.isArray(
      errorObject.details,
    )
      ? errorObject.details
      : errorObject?.fields &&
          typeof errorObject.fields ===
            "object" &&
          !Array.isArray(
            errorObject.fields,
          )
        ? errorObject.fields
        : errorObject?.errors &&
            typeof errorObject.errors ===
              "object" &&
            !Array.isArray(
              errorObject.errors,
            )
          ? errorObject.errors
          : errorObject;

  const excludedKeys =
    new Set([
      "success",
      "status",
      "status_code",
      "code",
      "message",
      "detail",
      "error",
      "non_field_errors",
      "fields",
      "errors",
      "details",
    ]);

  return Object.fromEntries(
    Object.entries(
      fieldSource,
    )
      .filter(
        ([fieldName]) =>
          !excludedKeys.has(
            fieldName,
          ),
      )
      .map(
        ([
          fieldName,
          messages,
        ]) => [
          fieldName,
          normalizeMessages(
            messages,
          ),
        ],
      )
      .filter(
        ([, messages]) =>
          messages.length > 0,
      ),
  );
}

function normalizeMessages(
  value,
) {
  if (
    value === null ||
    value === undefined
  ) {
    return [];
  }

  if (Array.isArray(value)) {
    return value
      .flatMap(
        normalizeMessages,
      )
      .filter(Boolean);
  }

  if (
    typeof value ===
    "object"
  ) {
    return Object.values(value)
      .flatMap(
        normalizeMessages,
      )
      .filter(Boolean);
  }

  return [
    String(value),
  ];
}

function normalizeMessage(
  value,
) {
  if (
    value === null ||
    value === undefined
  ) {
    return null;
  }

  if (Array.isArray(value)) {
    const firstMessage =
      value
        .flatMap(
          normalizeMessages,
        )
        .find(Boolean);

    return firstMessage
      ? String(firstMessage)
      : null;
  }

  if (
    typeof value ===
    "object"
  ) {
    const firstMessage =
      Object.values(value)
        .flatMap(
          normalizeMessages,
        )
        .find(Boolean);

    return firstMessage
      ? String(firstMessage)
      : null;
  }

  return String(value);
}
