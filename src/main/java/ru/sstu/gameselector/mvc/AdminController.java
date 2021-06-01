package ru.sstu.gameselector.mvc;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.sstu.gameselector.service.NodeService;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final NodeService nodeService;

    @GetMapping
    public String adminPage(Model model) {
        model.addAttribute("root", nodeService.getAll());

        return "admin";
    }
}
