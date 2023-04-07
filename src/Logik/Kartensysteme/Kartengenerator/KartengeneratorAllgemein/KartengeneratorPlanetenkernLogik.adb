with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with LadezeitenLogik;
with ZufallegeneratorenAllgemein;

-- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen,
-- dann muss ich das hier wegverschieben da der Zugriff ebenfall in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
package body KartengeneratorPlanetenkernLogik is

   procedure Planetenkern
   is begin
      
      Kartenzeitwert := (LeseWeltkarteneinstellungen.YAchse + (25 - 1)) / 25;
      
      YKernanfang := LeseWeltkarteneinstellungen.YAchse / 2 - LeseWeltkarteneinstellungen.YAchse / 10;
      XKernanfang := LeseWeltkarteneinstellungen.XAchse / 2 - LeseWeltkarteneinstellungen.XAchse / 10;
      YKernende := LeseWeltkarteneinstellungen.YAchse / 2 + LeseWeltkarteneinstellungen.YAchse / 10;
      XKernende := LeseWeltkarteneinstellungen.XAchse / 2 + LeseWeltkarteneinstellungen.XAchse / 10;
               
      YAchseSchleife:
      for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
            
            if
              YAchseSchleifenwert in YKernanfang .. YKernende
              and
                XAchseSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
               
            elsif
              YAchseSchleifenwert in YKernanfang - 1 .. YKernende + 1
              and
                XAchseSchleifenwert in XKernanfang - 1 .. XKernende + 1
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Lava_Enum);
               
            else
               BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, YAchseSchleifenwert, XAchseSchleifenwert));
            end if;
               
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
               
   end Planetenkern;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Basisgrund_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
           or
             GezogeneZahl = 0
         then
            null;
         
         elsif
           (GezogeneZahl = Zahlenspeicher
            and
              ZufallegeneratorenAllgemein.Münzwurf = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcherGrund := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                          GrundExtern       => KartengrundDatentypen.Lava_Enum);
            return;
            
         when others =>
            WelcherGrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => WelcherGrund);
      end case;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum'Range =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                          GrundExtern       => WelcherGrund);
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                          GrundExtern       => KartengrundDatentypen.Lava_Enum);
      end case;
      
   end BasisgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Ringwoodit_Enum =>
            return ZusatzberechnungRingwoodit (KoordinatenExtern => KoordinatenExtern,
                                               GrundExtern       => WelcherGrund);
            
         when KartengrundDatentypen.Majorit_Enum =>
            return ZusatzberechnungMajorit (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => WelcherGrund);
            
         when KartengrundDatentypen.Perowskit_Enum =>
            return ZusatzberechnungPerowskit (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => WelcherGrund);
            
         when KartengrundDatentypen.Magnesiowüstit_Enum =>
            return ZusatzberechnungMagnesiowüstit (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => WelcherGrund);
      end case;
      
   end BasisExtraberechnungen;
   
   
   
   function ZusatzberechnungRingwoodit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungRingwoodit;
   
   
   
   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMajorit;
   
   
   
   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungPerowskit;
   
   
   
   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMagnesiowüstit;

end KartengeneratorPlanetenkernLogik;
