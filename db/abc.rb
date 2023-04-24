
class Post
    belongs_to: user
    user_id
end


class User
    has_one: post
    has_many: comments
    user_id
end

class Comment
    belongs_to: user
end

posts
id user_id description

users
id name 

comments
id user_id text

array = [5, 3, 1, 4, 2]

index_1 = 0
def swap(array,index_1,index_2)
    temp = array[index_1]
    array[index_1] = array[index_2]
    array[index_2] = temp
end

array.each do |item|
    index_2 = index_1 + 1 if index_1.length <= array.length
    sub_array = array.slice(index_1,array.length)
    sub_array.each do |element|
        if item > element
            swap(array,index_1,index_2)
        end
        index_2++
    end
    index_1++
end