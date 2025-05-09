with ForschungenDatentypen;
with ProduktionDatentypen;

package ForschungKonstanten is
   pragma Pure;
   
   LeerKosten : constant ProduktionDatentypen.Einzelproduktion := 0;
   
   LeerForschung : constant ForschungenDatentypen.ForschungID := ForschungenDatentypen.ForschungID'First;
   LeerAnforderung : constant ForschungenDatentypen.ForschungID := ForschungenDatentypen.ForschungID'First;
   ForschungUnmöglich : constant ForschungenDatentypen.ForschungIDUnmöglich := ForschungenDatentypen.ForschungIDUnmöglich'First;
   
   -- Solle sich die Anzahl der Forschungen nicht zu weit erhöhen könnte man das auch als 2 statt 4 Bytes speichern und noch einmal 2 Byte pro Speicherung sparen.
   type ForschungsbereichArray is array (1 .. 3) of ForschungenDatentypen.ForschungIDVorhanden;
   Forschunganfang : constant ForschungsbereichArray := (1 => ForschungenDatentypen.ForschungIDVorhanden'First,
                                                         2 => 33,
                                                         3 => 65);

   Forschungsende : constant ForschungsbereichArray := (1 => 32,
                                                        2 => 64,
                                                        3 => ForschungenDatentypen.ForschungIDVorhanden'Last);
   
end ForschungKonstanten;
