(def input
  (->> (slurp "input.txt")
       clojure.string/split-lines
       (map #(Integer/parseInt %))))

(println (reduce + input))
