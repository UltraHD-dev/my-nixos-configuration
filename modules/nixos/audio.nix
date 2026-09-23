{ config, pkgs, ... }:

{
  # PulseAudio отключаем — его заменяет PipeWire.
  services.pulseaudio.enable = false;

  # rtkit даёт PipeWire право повышать приоритет аудио-потоков.
  # Без него будут заикания и щелчки.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;               # включаем сам сервер
    alsa.enable = true;          # поддержка ALSA (нужна многим приложениям)
    alsa.support32Bit = true;    # 32-битные библиотеки — для Steam и старого софта
    pulse.enable = true;         # эмуляция PulseAudio API
    # jack.enable = true;        # раскомментируйте, если нужны JACK-приложения
  };
}