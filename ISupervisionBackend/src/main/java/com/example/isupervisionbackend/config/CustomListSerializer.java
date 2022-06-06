package com.example.isupervisionbackend.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CustomListSerializer extends StdSerializer<List<Object>> {

    public CustomListSerializer(Class<List<Object>> t) {
        super(t);
    }

    public CustomListSerializer() {
        this(null);
    }
    @Override
    public void serialize(
            List<Object> items,
            JsonGenerator generator,
            SerializerProvider provider)
            throws IOException {

        List<Object> ids = new ArrayList<>();
        for (Object item : items) {
            ids.add(item);
        }
        generator.writeObject(ids);
    }
}
