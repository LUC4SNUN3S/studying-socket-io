import dayjs from "dayjs";
import { io } from "./http";

interface RoomUser {
    socketId: string
    username: string
    room: string

}

interface IMessage { 
room: string,
username: string,
message: string,
createdAt: string
}

const users : RoomUser[] = [];

const messages: IMessage[] = [];

io.on("connection", (socket) => {
    console.log(`User connected on socket ${socket.id}`);
    socket.on("select_room", (data) => {
        socket.join(data.room);
        
        const userInRoom = users.find(user => user.username === data.username && user.room === data.room);
        
        if(userInRoom) {
            userInRoom.socketId = socket.id;
        }else{
            users.push({
                socketId: socket.id,
                username: data.username,
                room: data.room
            })
        }
        
        socket.on("message", (data) => {
            const message: IMessage = {
                room: data.room,
                username: data.username,
                message: data.message,
                createdAt: dayjs().format("DD/MM/YY [as] HH:mm:ss")
            };

            messages.push(message);
            
            io.to(data.room).emit("message", message);
            
        })
    });

})