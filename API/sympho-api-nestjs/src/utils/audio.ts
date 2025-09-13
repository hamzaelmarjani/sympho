export async function extractUint8Array(
  stream: ReadableStream<Uint8Array>,
): Promise<number[] | null> {
  try {
    const reader = stream.getReader();
    const chunks: number[] = [];

    while (true) {
      const { value, done } = await reader.read();
      if (done) break;
      if (value) {
        chunks.push(...Array.from(value));
      }
    }

    return chunks;
  } catch (err) {
    console.error(err);
    return null;
  }
}
