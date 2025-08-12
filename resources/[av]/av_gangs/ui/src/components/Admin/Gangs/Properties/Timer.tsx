import { useState, useEffect } from "react";

interface TimerProps {
  deadline: number;
}

export const Timer = ({ deadline }: TimerProps) => {
  const [currentTime, setCurrentTime] = useState("");
  const [timeRemaining, setTimeRemaining] = useState(
    deadline - Math.floor(Date.now() / 1000)
  );

  const secondsToHMS = (sec: number): string => {
    const hours = Math.floor(sec / 3600);
    const minutes = Math.floor((sec % 3600) / 60);
    const remainingSeconds = sec % 60;

    const formattedHours = hours < 10 ? `0${hours}` : `${hours}`;
    const formattedMinutes = minutes < 10 ? `0${minutes}` : `${minutes}`;
    const formattedSeconds =
      remainingSeconds < 10 ? `0${remainingSeconds}` : `${remainingSeconds}`;

    return `${formattedHours}:${formattedMinutes}:${formattedSeconds}`;
  };

  useEffect(() => {
    const interval = setInterval(() => {
      const now = Math.floor(Date.now() / 1000);
      const timeDiff = deadline - now;
      setTimeRemaining(timeDiff);
      setCurrentTime(secondsToHMS(timeDiff));
    }, 1000);

    return () => clearInterval(interval);
  }, [deadline]);

  return <>{timeRemaining > 0 ? currentTime : `00:00:00`}</>;
};
