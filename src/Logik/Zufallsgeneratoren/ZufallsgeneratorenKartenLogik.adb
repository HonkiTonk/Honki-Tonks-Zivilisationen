with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

-- Die Zufallgeneratoren und ihre Funktionen/Prozeduren mal besser benennen. äöü
package body ZufallsgeneratorenKartenLogik is
   
   function KartengeneratorZufallswerte
     return SystemDatentypenHTSEB.NullBisHundert
   is begin
      
      ZufälligeZahl.Reset (Gen => ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (Gen => ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorLandgrößen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      Landgröße := KartengeneratorVariablenLogik.LandgrößenLesen;
            
      if
        Landgröße.MinimaleSenkrechte > LeseWeltkarteneinstellungen.Senkrechte
      then
         Landgröße.MinimaleSenkrechte := LeseWeltkarteneinstellungen.Senkrechte;
               
      else
         null;
      end if;
            
      if
        Landgröße.MaximaleSenkrechte > LeseWeltkarteneinstellungen.Senkrechte
      then
         Landgröße.MaximaleSenkrechte := LeseWeltkarteneinstellungen.Senkrechte;
               
      else
         null;
      end if;

            
      if
        Landgröße.MinimaleWaagerechte > LeseWeltkarteneinstellungen.Waagerechte
      then
         Landgröße.MinimaleWaagerechte := LeseWeltkarteneinstellungen.Waagerechte;
               
      else
         null;
      end if;
            
      if
        Landgröße.MaximaleWaagerechte > LeseWeltkarteneinstellungen.Waagerechte
      then
         Landgröße.MaximaleWaagerechte := LeseWeltkarteneinstellungen.Waagerechte;
         
      else
         null;
      end if;
      
      if
        Landgröße.MinimaleSenkrechte > Landgröße.MaximaleSenkrechte
      then
         Zwischenspeicher.Senkrechte := Landgröße.MinimaleSenkrechte;
         Landgröße.MinimaleSenkrechte := Landgröße.MaximaleSenkrechte;
         Landgröße.MaximaleSenkrechte := Zwischenspeicher.Senkrechte;

      else
         null;
      end if;
      
      if
        Landgröße.MinimaleWaagerechte > Landgröße.MaximaleWaagerechte
      then
         Zwischenspeicher.Waagerechte := Landgröße.MinimaleWaagerechte;
         Landgröße.MinimaleWaagerechte := Landgröße.MaximaleWaagerechte;
         Landgröße.MaximaleWaagerechte := Zwischenspeicher.Waagerechte;

      else
         null;
      end if;
      
      ZufälligeSenkrechteLandgrößen.Reset (Gen => ZufälligeSenkrechteLandgrößeGewählt);
      ZufälligeWaagerechteLandgrößen.Reset (Gen => ZufälligeWaagerechteLandgrößeGewählt);
      
      return (ZufälligeSenkrechteLandgrößen.Random (Gen   => ZufälligeSenkrechteLandgrößeGewählt,
                                                       First => Landgröße.MinimaleSenkrechte,
                                                       Last  => Landgröße.MaximaleSenkrechte),
              ZufälligeWaagerechteLandgrößen.Random (Gen   => ZufälligeWaagerechteLandgrößeGewählt,
                                                        First => Landgröße.MinimaleWaagerechte,
                                                        Last  => Landgröße.MaximaleWaagerechte));
              
   end KartengeneratorLandgrößen;
   
   
   
   function KartengeneratorRohstoffe
     return KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum
   is begin
      
      ZufälligerRohstoff.Reset (Gen => ZufälligerRohstoffGewählt);
      
      return ZufälligerRohstoff.Random (Gen => ZufälligerRohstoffGewählt);
      
   end KartengeneratorRohstoffe;
   
   
   
   function KartengeneratorRohstoffbereich
     (AnfangExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      EndeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum
   is begin
      
      ZufälligerRohstoff.Reset (Gen => ZufälligerRohstoffGewählt);
      
      return ZufälligerRohstoff.Random (Gen   => ZufälligerRohstoffGewählt,
                                         First => AnfangExtern,
                                         Last  => EndeExtern);
      
   end KartengeneratorRohstoffbereich;

end ZufallsgeneratorenKartenLogik;
