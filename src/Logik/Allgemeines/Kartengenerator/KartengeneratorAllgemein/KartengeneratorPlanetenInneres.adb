pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorPlaneteninneres is

   procedure Planeteninneres
   is begin
      
      YKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
      YKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            if
              YAchseSchleifenwert in YKernanfang .. YKernende
              and
                XAchseSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                             GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
               
            else
               BasisgrundBestimmen (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert));
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
               
   end Planeteninneres;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         BasisZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
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
            when KartengrundDatentypen.Leer_Grund_Enum =>
               WelcherGrund := WahrscheinlichkeitSchleifenwert; 
                        
            when others =>
               if
                 BasisZahlen (WahrscheinlichkeitSchleifenwert) > BasisZahlen (WelcherGrund)
               then
                  WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
               elsif
                 BasisZahlen (WahrscheinlichkeitSchleifenwert) = BasisZahlen (WelcherGrund)
                 and
                   ZufallsgeneratorenKarten.KartengeneratorBoolean = True
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
         when KartengrundDatentypen.Leer_Grund_Enum =>
            return;
            
         when others =>
            WelcherGrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => WelcherGrund);
      end case;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range =>
            SchreibeKarten.AktuellerGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                           GrundExtern       => WelcherGrund);
            
         when others =>
            null;
      end case;
      
   end BasisgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
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

end KartengeneratorPlaneteninneres;
