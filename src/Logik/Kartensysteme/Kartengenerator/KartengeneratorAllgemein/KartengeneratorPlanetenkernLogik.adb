with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with LadezeitenLogik;
with ZufallsgeneratorenHTSEB;

-- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen, äöü
-- dann muss ich das hier wegverschieben da der Zugriff ebenfall in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
package body KartengeneratorPlanetenkernLogik is

   procedure Planetenkern
   is begin
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => LeseWeltkarteneinstellungen.Senkrechte,
                                       TeilerExtern     => 25);
      
      YKernanfang := LeseWeltkarteneinstellungen.Senkrechte / 2 - LeseWeltkarteneinstellungen.Senkrechte / 10;
      XKernanfang := LeseWeltkarteneinstellungen.Waagerechte / 2 - LeseWeltkarteneinstellungen.Waagerechte / 10;
      YKernende := LeseWeltkarteneinstellungen.Senkrechte / 2 + LeseWeltkarteneinstellungen.Senkrechte / 10;
      XKernende := LeseWeltkarteneinstellungen.Waagerechte / 2 + LeseWeltkarteneinstellungen.Waagerechte / 10;
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            if
              SenkrechteSchleifenwert in YKernanfang .. YKernende
              and
                WaagerechteSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
               
            elsif
              SenkrechteSchleifenwert in YKernanfang - 1 .. YKernende + 1
              and
                WaagerechteSchleifenwert in XKernanfang - 1 .. XKernende + 1
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Lava_Enum);
               
            else
               BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
            end if;
               
         end loop WaagerechteSchleife;
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
               
   end Planetenkern;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
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
              ZufallsgeneratorenHTSEB.Münzwurf = True)
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
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
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
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => WelcherGrund);
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => KartengrundDatentypen.Lava_Enum);
      end case;
      
   end BasisgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
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
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungRingwoodit;
   
   
   
   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMajorit;
   
   
   
   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungPerowskit;
   
   
   
   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMagnesiowüstit;

end KartengeneratorPlanetenkernLogik;
