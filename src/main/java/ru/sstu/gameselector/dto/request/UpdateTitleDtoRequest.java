package ru.sstu.gameselector.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateTitleDtoRequest {

    private long id;
    private String title;
}
