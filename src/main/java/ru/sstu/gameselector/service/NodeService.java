package ru.sstu.gameselector.service;

import ru.sstu.gameselector.dto.response.NodeDtoResponse;
import ru.sstu.gameselector.dto.response.TreeDtoResponse;

public interface NodeService {

    void yes();

    void no();

    NodeDtoResponse getCurrent();

    TreeDtoResponse getAll();

    void restart();

    void updateTitle(long id, String title);

    void updateType(long id);
}
