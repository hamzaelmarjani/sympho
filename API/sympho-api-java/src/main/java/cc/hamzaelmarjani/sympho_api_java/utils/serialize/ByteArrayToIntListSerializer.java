package cc.hamzaelmarjani.sympho_api_java.utils.serialize;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import java.io.IOException;

public class ByteArrayToIntListSerializer extends JsonSerializer<byte[]> {
    @Override
    public void serialize(byte[] value, JsonGenerator gen, SerializerProvider serializers)
            throws IOException {
        if (value == null) {
            gen.writeNull();
            return;
        }

        gen.writeStartArray();
        for (byte b : value) {
            gen.writeNumber(Byte.toUnsignedInt(b)); // Convert signed byte to unsigned int (0-255)
        }
        gen.writeEndArray();
    }
}