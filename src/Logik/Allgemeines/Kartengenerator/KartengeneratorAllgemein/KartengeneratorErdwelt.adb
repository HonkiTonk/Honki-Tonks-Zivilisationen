pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      BasisgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
      ZusatzgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
   end KartengeneratorErdwelt;
   
   
   
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
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in Boolean'Range loop
         WahrscheinlichkeitSchleife:
         for WahrscheinlichkeitSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
            
            if
              DurchlaufSchleifenwert = False
              and
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
               null;
            
            when others =>
               exit DurchlaufSchleife;
         end case;
         
      end loop DurchlaufSchleife;
      
      WelcherGrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => WelcherGrund);
      
      SchreibeKarten.ZweimalGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                   GrundExtern       => WelcherGrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      null;
      
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Erde_Enum =>
            return ZusatzberechnungErde (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Erdgestein_Enum =>
            return ZusatzberechnungErdgestein (KoordinatenExtern => KoordinatenExtern,
                                               GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Sand_Enum =>
            return ZusatzberechnungSand (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Gestein_Enum =>
            return ZusatzberechnungGestein (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
      end case;
      
   end BasisExtraberechnungen;
   
   
   
   function ZusatzberechnungErde
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErde;
   
   
   
   function ZusatzberechnungErdgestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErdgestein;
   
   
   
   function ZusatzberechnungSand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungSand;
   
   
   
   function ZusatzberechnungGestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGestein;

end KartengeneratorErdwelt;
