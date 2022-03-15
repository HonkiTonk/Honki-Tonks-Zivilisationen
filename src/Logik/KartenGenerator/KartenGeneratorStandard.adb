pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenGrundKonstanten;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallGeneratorenKarten;
with KarteKoordinatenPruefen;
with KartenGeneratorHimmel;
with KartenGeneratorWeltraum;
with KartenGeneratorPlanetenInneres;

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
         when KartenEinstellungenKonstanten.KartenartLandKonstante =>
            GenerierungNurLand;
            
         when others =>
            StandardKarteGenerieren;
      end case;
      
   end StandardKarte;
   
   
   
   procedure StandardKarteGenerieren
   is begin
      
      -- Zu beachten, diese Werte sind nur dazu da um belegte Felder zu ermitteln. Nicht später durch die Zuweisungen weiter unten verwirren lassen!
      Karten.GeneratorKarte := (others => (others => (KartenGrundKonstanten.LeerGrund)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) = KartenGrundKonstanten.LeerGrund
            then
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => KartenGrundKonstanten.WasserKonstante);

            else
               null;
            end if;
                   
            GenerierungKartenart (YAchseExtern => YAchseSchleifenwert,
                                  XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StandardKarteGenerieren;



   procedure GenerierungKartenart
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin

      case
        Karten.GeneratorKarte (YAchseExtern, XAchseExtern)
      is
         when KartenGrundKonstanten.LeerGrund =>
            if
              YAchseExtern <= Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartengröße)
              or
                YAchseExtern >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisschild (Karten.Kartengröße)
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
               SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                     GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
               
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;
   
   
   
   procedure LandFeldMasseEisschild
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Eisschild).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Eisschild).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
         GenerierungLandmasse (YKoordinateLandmasseExtern => YAchseExtern,
                               XKoordinateLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Eisschild).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Eisschild).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
                           
      else
         null;
      end if;
      
   end LandFeldMasseEisschild;
   
   
   
   procedure LandFeldMasseNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;

      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Normal).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Masse_Normal).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
         GenerierungLandmasse (YKoordinateLandmasseExtern => YAchseExtern,
                               XKoordinateLandmasseExtern => XAchseExtern);
                  
      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Normal).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Normal).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
                  
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
      for YÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart).YAchse .. Karten.GrößeLandart (Karten.Kartenart).YAchse loop
         XAchseLandflächeErzeugenSchleife:
         for XÄnderungEinsSchleifenwert in -Karten.GrößeLandart (Karten.Kartenart).XAchse .. Karten.GrößeLandart (Karten.Kartenart).XAchse loop
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => (0, YKoordinateLandmasseExtern, XKoordinateLandmasseExtern),
                                                                           ÄnderungExtern    => (0, YÄnderungEinsSchleifenwert, XÄnderungEinsSchleifenwert),
                                                                           LogikGrafikExtern => True);
            
            -- Theoretisch sollte die erste Prüfung nicht nötig sein, da die Zweite nei einer LeerAchse auch nicht erfüllt sein dürfte.
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert.YAchse <= Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartengröße)
              or
                KartenWert.YAchse >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisschild (Karten.Kartengröße)
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
      for YÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenart).YAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenart).YAchse loop
         XAchseAbstandFlächenSchleife:
         for XÄnderungZweiSchleifenwert in -Karten.FelderVonLandartZuLandart (Karten.Kartenart).XAchse .. Karten.FelderVonLandartZuLandart (Karten.Kartenart).XAchse loop
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => (0, YKoordinateLandmasseExtern, XKoordinateLandmasseExtern),
                                                                           ÄnderungExtern    => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert),
                                                                           LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = KartenGrundDatentypen.Eis
            then
               null;
                  
            else
               Karten.GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := KartenGrundDatentypen.Flachland;  
            end if;
            
         end loop XAchseAbstandFlächenSchleife;
      end loop YAchseAbstandFlächenSchleife;
      
   end AbstandGenerieren;
   
   
   
   procedure GenerierungLandmasseFläche
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
   
      BeliebigerLandwert := ZufallGeneratorenKarten.ZufälligerWert;
      
      if
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Frei).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Frei).Endwert
        and
          Karten.GeneratorKarte (YAchseExtern, XAchseExtern) = KartenGrundKonstanten.LeerGrund
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := KartenGrundKonstanten.EisKonstante;

      elsif
        BeliebigerLandwert in WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Belegt).Anfangswert .. WahrscheinlichkeitenLand (Karten.Kartenart, Feld_Fläche_Belegt).Endwert
      then
         SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
         Karten.GeneratorKarte (YAchseExtern, XAchseExtern) := KartenGrundKonstanten.EisKonstante;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseFläche;
   
   
   
   procedure GenerierungNurLand
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.FlachlandKonstante);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungNurLand;
   
   
   
   procedure EisrandGenerieren
   is begin
      
      YAchseEisSchleife:
      for YAchseEisSchleifenwert in Karten.WeltkarteArray'First (2) .. KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseEisSchleife:
         for XAchseEisSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
         
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseEisSchleifenwert, XAchseEisSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.EisKonstante);
            SchreibeKarten.Grund (KoordinatenExtern => (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - YAchseEisSchleifenwert + 1, XAchseEisSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.EisKonstante);
            SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseEisSchleifenwert, XAchseEisSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.UnterwasserEisKonstante);
            SchreibeKarten.Grund (KoordinatenExtern => (-1, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - YAchseEisSchleifenwert + 1, XAchseEisSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.UnterwasserEisKonstante);
         
         end loop XAchseEisSchleife;
      end loop YAchseEisSchleife;
      
   end EisrandGenerieren;

end KartenGeneratorStandard;
