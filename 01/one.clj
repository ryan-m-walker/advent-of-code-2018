(require '[clojure.string :as str])

(defn calc [shifts]
  (reduce + shifts))

(let [shifts (->> (slurp "input.txt")
                  str/split-lines
                  (map #(Integer/parseInt %)))]
  (println (calc shifts)))
