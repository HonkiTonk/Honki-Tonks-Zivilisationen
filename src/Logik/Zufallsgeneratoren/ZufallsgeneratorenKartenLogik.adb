with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body ZufallsgeneratorenKartenLogik is
   
   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert
   is begin
      
      ZufälligeZahl.Reset (Gen => ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (Gen => ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorLandgrößen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Minimalwert.Senkrechte := KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte;
      Maximalwert.Senkrechte := KartengeneratorVariablenLogik.Landgrößen.MaximaleSenkrechte;
      
      Minimalwert.Waagerechte := KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte;
      Maximalwert.Waagerechte := KartengeneratorVariablenLogik.Landgrößen.MaximaleWaagerechte;
            
      if
        Minimalwert.Senkrechte > LeseWeltkarteneinstellungen.Senkrechte
      then
         Minimalwert.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte;
               
      else
         null;
      end if;
            
      if
        Maximalwert.Senkrechte > LeseWeltkarteneinstellungen.Senkrechte
      then
         Maximalwert.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte;
               
      else
         null;
      end if;

            
      if
        Minimalwert.Waagerechte > LeseWeltkarteneinstellungen.Waagerechte
      then
         Minimalwert.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte;
               
      else
         null;
      end if;
            
      if
        Maximalwert.Waagerechte > LeseWeltkarteneinstellungen.Waagerechte
      then
         Maximalwert.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte;
               
      else
         null;
      end if;
      
      if
        Minimalwert.Senkrechte > Maximalwert.Senkrechte
      then
         Zwischenspeicher.Senkrechte := Minimalwert.Senkrechte;
         Minimalwert.Senkrechte := Maximalwert.Senkrechte;
         Maximalwert.Senkrechte := Zwischenspeicher.Senkrechte;

      else
         null;
      end if;
      
      if
        Minimalwert.Waagerechte > Maximalwert.Waagerechte
      then
         Zwischenspeicher.Waagerechte := Minimalwert.Waagerechte;
         Minimalwert.Waagerechte := Maximalwert.Waagerechte;
         Maximalwert.Waagerechte := Zwischenspeicher.Waagerechte;

      else
         null;
      end if;
      
      ZufälligeSenkrechteLandgrößen.Reset (Gen => ZufälligeSenkrechteLandgrößeGewählt);
      ZufälligeWaagerechteLandgrößen.Reset (Gen => ZufälligeWaagerechteLandgrößeGewählt);
      
      return (ZufälligeSenkrechteLandgrößen.Random (Gen   => ZufälligeSenkrechteLandgrößeGewählt,
                                                       First => Minimalwert.Senkrechte,
                                                       Last  => Maximalwert.Senkrechte),
              ZufälligeWaagerechteLandgrößen.Random (Gen   => ZufälligeWaagerechteLandgrößeGewählt,
                                                        First => Minimalwert.Waagerechte,
                                                        Last  => Maximalwert.Waagerechte));
              
   end KartengeneratorLandgrößen;

end ZufallsgeneratorenKartenLogik;
