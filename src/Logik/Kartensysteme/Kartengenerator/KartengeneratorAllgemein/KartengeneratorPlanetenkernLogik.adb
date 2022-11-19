with LadezeitenDatentypen;
with KartenKonstanten;
with Weltkarte;

with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with LadezeitenLogik;

package body KartengeneratorPlanetenkernLogik is

   procedure Planetenkern
   is begin
      
      Kartenzeitwert := (LeseWeltkarteneinstellungen.YAchse + (25 - 1)) / 25;
      
      YKernanfang := LeseWeltkarteneinstellungen.YAchse / 2 - LeseWeltkarteneinstellungen.YAchse / 10;
      XKernanfang := LeseWeltkarteneinstellungen.XAchse / 2 - LeseWeltkarteneinstellungen.XAchse / 10;
      YKernende := LeseWeltkarteneinstellungen.YAchse / 2 + LeseWeltkarteneinstellungen.YAchse / 10;
      XKernende := LeseWeltkarteneinstellungen.XAchse / 2 + LeseWeltkarteneinstellungen.XAchse / 10;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. LeseWeltkarteneinstellungen.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. LeseWeltkarteneinstellungen.XAchse loop
            
            if
              YAchseSchleifenwert in YKernanfang .. YKernende
              and
                XAchseSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.PlaneteninneresKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
               
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
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         BasisZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           BasisZahlen (ZufallszahlSchleifenwert) < BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      WahrscheinlichkeitSchleife:
      for WahrscheinlichkeitSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
            
         if
           BasisMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
         then
            null;
         
         else
            case
              WelcherGrund
            is
            when KartengrundDatentypen.Leer_Basisgrund_Enum =>
               WelcherGrund := WahrscheinlichkeitSchleifenwert; 
                        
            when others =>
               if
                 BasisZahlen (WahrscheinlichkeitSchleifenwert) > BasisZahlen (WelcherGrund)
               then
                  WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
               elsif
                 BasisZahlen (WahrscheinlichkeitSchleifenwert) = BasisZahlen (WelcherGrund)
                 and
                   ZufallsgeneratorenKartenLogik.KartengeneratorBoolean = True
               then
                  WelcherGrund := WahrscheinlichkeitSchleifenwert;
                           
               else
                  null;
               end if;
            end case;
         end if;
            
      end loop WahrscheinlichkeitSchleife;
      
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
