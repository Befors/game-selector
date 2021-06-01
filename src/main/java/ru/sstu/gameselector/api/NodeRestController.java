package ru.sstu.gameselector.api;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import ru.sstu.gameselector.service.NodeService;

@RestController
@RequestMapping("/api/nodes")
@RequiredArgsConstructor
public class NodeRestController {

    private final NodeService nodeService;

    @PostMapping("/next/yes")
    public void yes() {
        nodeService.yes();
    }

    @PostMapping("/next/no")
    public void no() {
        nodeService.no();
    }

    @PostMapping("/restart")
    public void restart() {
        nodeService.restart();
    }

    @PutMapping("/{id}/title")
    @PreAuthorize("hasRole('ADMIN')")
    public void updateTitle(@PathVariable long id,
                            @RequestBody String title) {
        nodeService.updateTitle(id, title);
    }

    @PostMapping("/{id}/type")
    @PreAuthorize("hasRole('ADMIN')")
    public void updateType(@PathVariable long id) {
        nodeService.updateType(id);
    }
}
