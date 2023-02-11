package mark.kovari.todoapplication.persistance

import androidx.room.Database
import androidx.room.RoomDatabase
import mark.kovari.todoapplication.dao.TodoDao
import mark.kovari.todoapplication.model.Todo

@Database(entities = [Todo::class], version = 1)
abstract class Persistance : RoomDatabase() {
    abstract fun todoDao(): TodoDao
}
