pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartenpoleKorrigieren;

package body KartenGeneratorStandard is
   
   procedure KarteGenerieren
   is begin
      
      Polkorrektur := KartenpoleKorrigieren.KartenpoleKorrigieren;
      
      -- Zu beachten, diese Werte sind nur dazu da um belegte Felder zu ermitteln. Nicht später durch die Zuweisungen weiter unten verwirren lassen!
      Karten.GeneratorKarte := (others => (others => (KartenGrundDatentypen.Leer_Grund_Enum)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + Polkorrektur.Norden .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße - Polkorrektur.Süden loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) + Polkorrektur.Westen .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße - Polkorrektur.Osten loop
               
            if
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundDatentypen.Leer_Grund_Enum
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => KartenGrundDatentypen.Wasser_Enum);

            else
               null;
            end if;
                   
            GenerierungKartenart (YAchseExtern => YAchseSchleifenwert,
                                  XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end KarteGenerieren;



   procedure GenerierungKartenart
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin

      case
        Karten.GeneratorKarte (YAchseExtern, XAchseExtern)
      is
         when KartenGrundDatentypen.Leer_Grund_Enum =>
            if
              YAchseExtern <= Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße)
              or
                YAchseExtern >= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße)
            then
               LandFeldMasseEisschild (YAchseExtern => YAchseExtern,
                                       XAchseExtern => XAchseExtern);
                              
            else
               LandFeldMasseNormal (YAchseExtern => YAchseExtern,
                                    XAchseExtern => XAchseExtern);
            end if;

         when others =>
            if
              ZufallsgeneratorenKarten.ZufälligerWert
            in
              WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Sonstiges_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Sonstiges_Enum).Endwert
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
               
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;
   
   
   
   procedure LandFeldMasseEisschild
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallsgeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Masse_Eisschild_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Masse_Eisschild_Enum).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
         GenerierungLandmasse (YKoordinateLandmasseExtern => YAchseExtern,
                               XKoordinateLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Eisschild_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Eisschild_Enum).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
                           
      else
         null;
      end if;
      
   end LandFeldMasseEisschild;
   
   
   
   procedure LandFeldMasseNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallsgeneratorenKarten.ZufälligerWert;

      if
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Masse_Normal_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Masse_Normal_Enum).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
         GenerierungLandmasse (YKoordinateLandmasseExtern => YAchseExtern,
                               XKoordinateLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Normal_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Normal_Enum).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
                  
      else
         null;
      end if;
      
   end LandFeldMasseNormal;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure GenerierungLandmasse
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      LandmasseGenerieren (YKoordinateLandmasseExtern => YKoordinateLandmasseExtern,
                           XKoordinateLandmasseExtern => XKoordinateLandmasseExtern);
      AbstandGenerieren (YKoordinateLandmasseExtern => YKoordinateLandmasseExtern,
                         XKoordinateLandmasseExtern => XKoordinateLandmasseExtern);
            
   end GenerierungLandmasse;
   
   
   
   -- Hier eventuell noch einmal drüber gehen, wenn die Sachen gedreht sind werden eventuell falsche Werte gesetzt.
   procedure LandmasseGenerieren
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseLandflächeErzeugenSchleife:
      for YÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenparameter.Kartenart).YAchse .. Karten.GrößeLandart (Karten.Kartenparameter.Kartenart).YAchse loop
         XAchseLandflächeErzeugenSchleife:
         for XÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenparameter.Kartenart).XAchse .. Karten.GrößeLandart (Karten.Kartenparameter.Kartenart).XAchse loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YKoordinateLandmasseExtern, XKoordinateLandmasseExtern),
                                                                                                 ÄnderungExtern    => (0, YÄnderungEinsSchleifenwert, XÄnderungEinsSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            -- Theoretisch sollte die erste Prüfung nicht nötig sein, da die Zweite nei einer LeerAchse auch nicht erfüllt sein dürfte.
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse <= Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße)
              or
                KartenWert.YAchse >= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße)
            then
               null;
               
            else
               GenerierungLandmasseFläche (YAchseExtern  => KartenWert.YAchse,
                                            XAchseExtern  => KartenWert.XAchse);
            end if;
            
         end loop XAchseLandflächeErzeugenSchleife;
      end loop YAchseLandflächeErzeugenSchleife;
      
   end LandmasseGenerieren;
   
   
   
   procedure AbstandGenerieren
     (YKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv;
      XKoordinateLandmasseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseAbstandFlächenSchleife:
      for YÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenparameter.Kartenart).YAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenparameter.Kartenart).YAchse loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenparameter.Kartenart).XAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenparameter.Kartenart).XAchse loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YKoordinateLandmasseExtern, XKoordinateLandmasseExtern),
                                                                                                 ÄnderungExtern    => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = KartenGrundDatentypen.Eis_Enum
            then
               null;
                  
            else
               Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := KartenGrundDatentypen.Flachland_Enum;  
            end if;
            
         end loop XAchseAbstandFlächenSchleife;
      end loop YAchseAbstandFlächenSchleife;
      
   end AbstandGenerieren;
   
   
   
   procedure GenerierungLandmasseFläche
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
   
      BeliebigerLandwert := ZufallsgeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Fläche_Frei_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Fläche_Frei_Enum).Endwert
        and
          Karten.GeneratorKarte (YAchseExtern, XAchseExtern) = KartenGrundDatentypen.Leer_Grund_Enum
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := KartenGrundDatentypen.Eis_Enum;

      elsif
        BeliebigerLandwert
      in
        WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Fläche_Belegt_Enum).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenparameter.Kartenart, Feld_Fläche_Belegt_Enum).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := KartenGrundDatentypen.Eis_Enum;
               
      else
         null;
      end if;
         
   end GenerierungLandmasseFläche;

end KartenGeneratorStandard;
