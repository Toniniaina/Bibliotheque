package bibliotheque.config;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Component
public class StringToInstantConverter implements Converter<String, Instant> {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    public Instant convert(String source) {
        if (source == null || source.isEmpty()) {
            return null;
        }

        try {
            // Parse the datetime-local format and convert to Instant
            LocalDateTime localDateTime = LocalDateTime.parse(source, FORMATTER);
            return localDateTime.atZone(ZoneId.systemDefault()).toInstant();
        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid date format: " + source);
        }
    }
}