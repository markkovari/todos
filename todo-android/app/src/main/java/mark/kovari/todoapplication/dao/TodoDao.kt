package mark.kovari.todoapplication.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import mark.kovari.todoapplication.model.Todo

@Dao
interface TodoDao {
    @Query("SELECT * FROM todo")
    fun getAll(): List<Todo>

    @Query("SELECT * FROM todo WHERE uid IN (:todoIds)")
    fun loadAllByIds(todIds: IntArray): List<Todo>

    @Query(
        "SELECT * FROM todo WHERE title LIKE :title AND " +
                "description LIKE :description LIMIT 1"
    )
    fun findByTitleAndDescription(title: String, description: String): Todo

    @Insert
    fun insertAll(vararg todo: Todo)

    @Delete
    fun delete(todo: Todo)
}