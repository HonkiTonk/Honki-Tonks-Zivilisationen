SpeziesDatentypen.Menschen_Enum         => ,
  SpeziesDatentypen.Kasrodiah_Enum        => ,
    SpeziesDatentypen.Lasupin_Enum          => ,
      SpeziesDatentypen.Lamustra_Enum         => ,
        SpeziesDatentypen.Manuky_Enum           => ,
          SpeziesDatentypen.Suroka_Enum           => ,
            SpeziesDatentypen.Pryolon_Enum          => ,
              SpeziesDatentypen.Moru_Phisihl_Enum     => ,
                SpeziesDatentypen.Larinos_Lotaris_Enum  => ,
                  SpeziesDatentypen.Carupex_Enum          => ,
                    SpeziesDatentypen.Alary_Enum            => ,
                      SpeziesDatentypen.Natries_Zermanis_Enum => ,
                        SpeziesDatentypen.Tridatus_Enum         => ,
                          SpeziesDatentypen.Senelari_Enum         => ,
                            SpeziesDatentypen.Aspari_2_Enum         => ,
                              SpeziesDatentypen.Ekropa_Enum           => ,
                                SpeziesDatentypen.Tesorahn_Enum         => ,
                                  SpeziesDatentypen.Talbidahr_Enum        =>



Menschen => bevorzugten Lebensräume sind Regionen mit gemäßigtem oder warmem Klima
Kasrodiah => in der Nähe fliesender Gewässer oder seichter Küstengebiete, innerhalb eines Klimas welches die permanenz des Wasser gewährleistet
Lasupin => allen Landklimazonen gleichmäßig vertreten
Lamustra => am liebsten in der Nähe fliesender Gewässer oder seichter Küstenregionen, allerdings haben sie keine Probleme mit kalten Regionen, in welchen das Wasser vorübergehen gefroren ist.
Manuky => Waldgebiete in gemäßigtem und kaltem Klima
Suroka => abgesehen von Wüsten und Eisgebieten, in allen Klimazonen
Pryolon => bevorzugt in Wäldern, Steppen und Bergregionen
Moru_Phisihl => alle Gebiete ohne Dschungel, Wüsten oder Sümpfe
Larinos_Lotaris => allen Klimazonen
Carupex => hohe Gebirge und höher gelegenes Flachland
Alary => emäßigten und warmen Regionen, aber niemals in dichten Wäldern
Natries_Zermanis => allen Landgebieten
Tridatus => Sümpfe oder Wälder in Fluss- und Küstennähe
Senelari => gemäßigtem und warmen Klima an Land
Aspari_2 => Alle Umgebungen auf denen Maschinen existieren können
Ekropa => bevorzugen bewaldete Flächen in gemäßigtem oder warmen Klima

Tesorahn => bevorzugter Lebensraum sind Salzgewässer in flüssigem Zustand
Talbidahr => Unterirdisch in gemäßigten Klimazonen



-- Ist das hier auch an anderen Stellen brauchbar? äöü
-- Bzw. überall einbauen und das aktuelle Viewflächensystem dadurch ersetzen oder erweitern?
if
  Textbreite > MaximaleTextbreite
then
   Skalierung := (MaximaleTextbreite / Textbreite, 1.00);
   Textbreite := MaximaleTextbreite;

else
   Skalierung := (1.00, 1.00);
end if;
