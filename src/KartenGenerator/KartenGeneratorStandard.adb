pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallGeneratorenKarten, KartePositionPruefen, KartenGeneratorHimmel, KartenGeneratorWeltraum, KartenGeneratorPlanetenInneres;

package body KartenGeneratorStandard is

   procedure StandardKarte
   is
   
      task Himmel;
      task Weltraum;
      task PlanetenInneres;
      
      task body Himmel
      is begin
         
         KartenGeneratorHimmel.Himmel;
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartenGeneratorWeltraum.Weltraum;
         
      end Weltraum;
      
      
      
      task body PlanetenInneres
      is begin
         
         KartenGeneratorPlanetenInneres.PlanetenInneres;
         
      end PlanetenInneres;
   
   begin
      
      EisrandGenerieren;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Nur_Land =>
            GenerierungNurLand;
            return;
            
         when others =>
            StandardKarteGenerieren;
      end case;
      
      
      
   end StandardKarte;
   
   
   
   procedure StandardKarteGenerieren
   is begin
      
      -- Zu beachten, diese Werte sind nur dazu da um belegte Felder zu ermitteln. Nicht später durch die Zuweisungen weiter unten verwirren lassen!
      Karten.GeneratorKarte := (others => (others => (GlobaleDatentypen.Leer)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              LeseKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) = GlobaleDatentypen.Leer
            then
               SchreibeKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern    => GlobaleDatentypen.Wasser);

            else
               null;
            end if;
                   
            GenerierungKartenart (YAchseExtern => YAchseSchleifenwert,
                                  XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StandardKarteGenerieren;



   procedure GenerierungKartenart
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin

      case
        Karten.GeneratorKarte (YAchseExtern, XAchseExtern)
      is
         when GlobaleDatentypen.Leer =>
            if
              YAchseExtern <= Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisschild (Karten.Kartengröße)
              or
                YAchseExtern >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisschild (Karten.Kartengröße)
            then
               LandFeldMasseEisschild (YAchseExtern => YAchseExtern,
                                       XAchseExtern => XAchseExtern);
                              
            else
               LandFeldMasseNormal (YAchseExtern => YAchseExtern,
                                    XAchseExtern => XAchseExtern);
            end if;

         when others =>
            if
              ZufallGeneratorenKarten.ZufälligerWert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Sonstiges).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Sonstiges).Endwert
            then
               SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern    => GlobaleDatentypen.Flachland);
               
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;
   
   
   
   procedure LandFeldMasseEisschild
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Eisschild).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Eisschild).Endwert
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
         GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                               XPositionLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Eisschild).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Eisschild).Endwert
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
                           
      else
         null;
      end if;
      
   end LandFeldMasseEisschild;
   
   
   
   procedure LandFeldMasseNormal
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;

      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Normal).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Normal).Endwert
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
         GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                               XPositionLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Normal).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Normal).Endwert
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
                  
      else
         null;
      end if;
      
   end LandFeldMasseNormal;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure GenerierungLandmasse
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      LandmasseGenerieren (YPositionLandmasseExtern => YPositionLandmasseExtern,
                           XPositionLandmasseExtern => XPositionLandmasseExtern);
      AbstandGenerieren (YPositionLandmasseExtern => YPositionLandmasseExtern,
                         XPositionLandmasseExtern => XPositionLandmasseExtern);
            
   end GenerierungLandmasse;
   
   
   
   procedure LandmasseGenerieren
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseLandflächeErzeugenSchleife:
      for YÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart).YAchse .. Karten.GrößeLandart (Karten.Kartenart).YAchse loop
         XAchseLandflächeErzeugenSchleife:
         for XÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart).XAchse .. Karten.GrößeLandart (Karten.Kartenart).XAchse loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungEinsSchleifenwert, XÄnderungEinsSchleifenwert));

            if
              KartenWert.YAchse <= Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisschild (Karten.Kartengröße)
              or
                KartenWert.YAchse >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisschild (Karten.Kartengröße)
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
     (YPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      YAchseAbstandFlächenSchleife:
      for YÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenart).YAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenart).YAchse loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenart).XAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenart).XAchse loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = GlobaleDatentypen.Eis
            then
               null;
                  
            else
               Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := GlobaleDatentypen.Flachland;  
            end if;
            
         end loop XAchseAbstandFlächenSchleife;
      end loop YAchseAbstandFlächenSchleife;
      
   end AbstandGenerieren;
   
   
   
   procedure GenerierungLandmasseFläche
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
   
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Frei).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Frei).Endwert
        and
          Karten.GeneratorKarte (YAchseExtern, XAchseExtern) = GlobaleDatentypen.Leer
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := Eis;

      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Belegt).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Belegt).Endwert
      then
         SchreibeKarten.Grund (PositionExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern    => GlobaleDatentypen.Flachland);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := GlobaleDatentypen.Eis;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseFläche;
   
   
   
   procedure GenerierungNurLand
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            SchreibeKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Flachland);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungNurLand;
   
   
   
   procedure EisrandGenerieren
   is begin
      
      YAchseEisSchleife:
      for YAchseEisSchleifenwert in Karten.WeltkarteArray'First (2) .. GlobaleKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseEisSchleife:
         for XAchseEisSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
         
            SchreibeKarten.Grund (PositionExtern => (0, YAchseEisSchleifenwert, XAchseEisSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Eis);
            SchreibeKarten.Grund (PositionExtern => (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - YAchseEisSchleifenwert + 1, XAchseEisSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Eis);
            SchreibeKarten.Grund (PositionExtern => (-1, YAchseEisSchleifenwert, XAchseEisSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Unterwasser_Eis);
            SchreibeKarten.Grund (PositionExtern => (-1, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - YAchseEisSchleifenwert + 1, XAchseEisSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Unterwasser_Eis);
         
         end loop XAchseEisSchleife;
      end loop YAchseEisSchleife;
      
   end EisrandGenerieren;

end KartenGeneratorStandard;
