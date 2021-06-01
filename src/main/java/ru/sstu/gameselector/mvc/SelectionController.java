package ru.sstu.gameselector.mvc;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.sstu.gameselector.service.NodeService;

@Controller
@RequestMapping("/selection")
@RequiredArgsConstructor
public class SelectionController {

    private final NodeService nodeService;

    @GetMapping
    public String selectionPage(Model model) {
        model.addAttribute("current", nodeService.getCurrent());

        return "selection";
    }
}
