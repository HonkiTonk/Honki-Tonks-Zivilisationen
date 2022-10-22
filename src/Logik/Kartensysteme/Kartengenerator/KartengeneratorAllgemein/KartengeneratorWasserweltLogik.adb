pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;

with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;

package body KartengeneratorWasserweltLogik is

   procedure KartengeneratorWasserwelt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      BasisgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
      ZusatzgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
   end KartengeneratorWasserwelt;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                    GrundExtern       => KartengrundDatentypen.Meeresgrund_Enum);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         ZusatzZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           ZusatzZahlen (ZufallszahlSchleifenwert) < ZusatzWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      WahrscheinlichkeitSchleife:
      for WahrscheinlichkeitSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
            
         if
           ZusatzMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
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
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) > ZusatzZahlen (WelcherGrund)
                  then
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
                  elsif
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) = ZusatzZahlen (WelcherGrund)
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
         when KartengrundDatentypen.Leer_Grund_Enum =>
            return;
            
         when others =>
            WelcherGrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                     GrundExtern       => WelcherGrund);
      end case;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range =>
            SchreibeWeltkarte.AktuellerGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                           GrundExtern       => WelcherGrund);
            
         when others =>
            null;
      end case;
      
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserbasis_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasserbasis_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            return ZusatzberechnungMeeresgrund (KoordinatenExtern => KoordinatenExtern,
                                                GrundExtern       => WelcherGrund);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      case
        GrundExtern
      is
            
         when KartengrundDatentypen.Korallen_Enum =>
            return ZusatzberechnungKorallen (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => WelcherGrund);
            
         when KartengrundDatentypen.Unterwald_Enum =>
            return ZusatzberechnungUnterwald (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => WelcherGrund);
      end case;
      
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungMeeresgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserbasis_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasserbasis_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMeeresgrund;
   
   
   
   function ZusatzberechnungKorallen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungKorallen;
   
   
   
   function ZusatzberechnungUnterwald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungUnterwald;

end KartengeneratorWasserweltLogik;
