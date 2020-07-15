Observer = class()

function Observer:init() self.__subjects = {} end

function Observer:notify(message)

    for index in pairs(self.__subjects) do
        message.__subjectID = index
        self.__subjects[index]:signal(message)
    end

end

function Observer:add(subject, id) self.__subjects[tostring(subject)] = subject end

function Observer:remove(subject)
    if self.__subjects[tostring(subject)] ~= nil then
        self.__subjects[tostring(subject)] = nil
    end
end
