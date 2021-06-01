package ru.sstu.gameselector.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.sstu.gameselector.model.enums.NodeType;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NodeDtoResponse {

    private String title;
    private NodeType type;
}
