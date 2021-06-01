package ru.sstu.gameselector.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.sstu.gameselector.dto.request.UpdateTitleDtoRequest;
import ru.sstu.gameselector.dto.request.UpdateTypeDtoRequest;
import ru.sstu.gameselector.dto.response.NodeDtoResponse;
import ru.sstu.gameselector.dto.response.TreeDtoResponse;
import ru.sstu.gameselector.service.NodeService;

@Service
@RequiredArgsConstructor
public class NodeServiceImpl implements NodeService {

    private final RestTemplate restTemplate;

    @Value("${prolog.endpoint.yes}")
    private String yesEndpoint;

    @Value("${prolog.endpoint.no}")
    private String noEndpoint;

    @Value("${prolog.endpoint.get-current}")
    private String getCurrentEndpoint;

    @Value("${prolog.endpoint.get-all}")
    private String getAllEndpoint;

    @Value("${prolog.endpoint.restart}")
    private String restartEndpoint;

    @Value("${prolog.endpoint.update-title}")
    private String updateTitleEndpoint;

    @Value("${prolog.endpoint.update-type}")
    private String updateTypeEndpoint;

    @Override
    public void yes() {
        restTemplate.postForObject(yesEndpoint, null, Void.class);
    }

    @Override
    public void no() {
        restTemplate.postForObject(noEndpoint, null, Void.class);
    }

    @Override
    public NodeDtoResponse getCurrent() {
        return restTemplate.getForObject(getCurrentEndpoint, NodeDtoResponse.class);
    }

    @Override
    public TreeDtoResponse getAll() {
        return restTemplate.getForObject(getAllEndpoint, TreeDtoResponse.class);
    }

    @Override
    public void restart() {
        restTemplate.postForObject(restartEndpoint, null, Void.class);
    }

    @Override
    public void updateTitle(long id, String title) {
        restTemplate.postForObject(updateTitleEndpoint, new UpdateTitleDtoRequest(id, title), Void.class);
    }

    @Override
    public void updateType(long id) {
        restTemplate.postForObject(updateTypeEndpoint, new UpdateTypeDtoRequest(id), Void.class);
    }
}
