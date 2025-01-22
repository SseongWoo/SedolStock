#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
        _In_ wchar_t *command_line, _In_ int show_command) {
// Attach to console when present (e.g., 'flutter run') or create a
// new console when running with a debugger.
if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
CreateAndAttachConsole();
}

// Initialize COM, so that it is available for use in the library and/or
// plugins.
::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

flutter::DartProject project(L"data");

std::vector<std::string> command_line_arguments =
        GetCommandLineArguments();

project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

FlutterWindow window(project);
Win32Window::Point origin(10, 10);
Win32Window::Size size(1080, 1920); // 초기 크기 설정

// 창 생성
if (!window.Create(L"stockpj", origin, size)) {
return EXIT_FAILURE;
}

// 크기 조절 비활성화
HWND hwnd = window.GetHandle(); // 윈도우 핸들 가져오기
LONG style = GetWindowLong(hwnd, GWL_STYLE); // 현재 스타일 가져오기
style &= ~WS_SIZEBOX;                        // 크기 조절 막기
style &= ~WS_MAXIMIZEBOX;                    // 최대화 버튼 비활성화
SetWindowLong(hwnd, GWL_STYLE, style);       // 스타일 적용

window.SetQuitOnClose(true);

// 메시지 루프
::MSG msg;
while (::GetMessage(&msg, nullptr, 0, 0)) {
::TranslateMessage(&msg);
::DispatchMessage(&msg);
}

::CoUninitialize();
return EXIT_SUCCESS;
}