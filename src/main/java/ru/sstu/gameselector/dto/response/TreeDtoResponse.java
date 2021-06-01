package ru.sstu.gameselector.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TreeDtoResponse {

    private long id;
    private String title;
    private TreeDtoResponse yes;
    private TreeDtoResponse no;
}
