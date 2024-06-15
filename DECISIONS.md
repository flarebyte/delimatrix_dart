# Architecture decision records

An [architecture
decision](https://cloud.google.com/architecture/architecture-decision-records)
is a software design choice that evaluates:

-   a functional requirement (features).
-   a non-functional requirement (technologies, methodologies, libraries).

The purpose is to understand the reasons behind the current architecture, so
they can be carried-on or re-visited in the future.

## Motivation

Traditionally, dealing with such cases involves parsing the JSON result in a single pass, expanding the content field into an object if necessary, and allowing the code to manage any type changes. Delimatrix, however, should employ a different approach by assuming two parsing phases.

In the first phase, the initial JSON is converted into an object while leaving the content field as a string. In the second phase, the content field is transformed into the appropriate object representation if needed. This method, although somewhat unconventional, introduces a higher level of flexibility but can pose a security risk if not implemented correctly.

Despite these challenges, the benefits are significant. This approach allows for a variety of models for the content field, which can evolve over time. Moreover, the second parsing phase can handle diverse formats such as JSON, YAML, CSV, Markdown, etc.

Additionally, the Delimatrix library addresses a common issue encountered when encoding a field in JSON and then encoding the result in JSON again. This process often involves numerous escaping codes, which can be noisy for a human reader. Delimatrix resolves this by converting characters that need to be escaped into characters that do not, simplifying the encoding process.

In summary, Delimatrix not only provides a powerful and flexible solution for transforming strings into objects and vice versa but also enhances the ease of handling complex content representations in various formats.