(require '[clojure.string :as str])

(defn calc [input]
  (->> (str/split-lines input)
       (map #(Integer/parseInt %))
       (reduce +)))

(println (calc (slurp "input.txt")))
