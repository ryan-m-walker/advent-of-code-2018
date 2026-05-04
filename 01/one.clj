(def input-data
  (-> (slurp "input.txt")
      clojure.string/split-lines
      (->> (map #(Integer/parseInt %)))))

(println (reduce + input-data))
