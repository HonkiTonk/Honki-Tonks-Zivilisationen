pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorRessourcenOberflaecheLand is

   procedure KartengeneratorRessourcenOberflächeLand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      WelcheRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
         
         GezogeneZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
         if
           GezogeneZahlen (ZufallszahlSchleifenwert) < KartenressourceWahrscheinlichkeit (ZufallszahlSchleifenwert)
         then
            WelcheMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            WelcheMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      WahrscheinlichkeitSchleife:
      for WahrscheinlichkeitSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
         
         if
           WelcheMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
         then
            null;
         
         else
            case
              WelcheRessource
            is
               when KartengrundDatentypen.Leer_Ressource_Enum =>
                  WelcheRessource := WahrscheinlichkeitSchleifenwert; 
                        
               when others =>
                  if
                    GezogeneZahlen (WahrscheinlichkeitSchleifenwert) > GezogeneZahlen (WelcheRessource)
                  then
                     WelcheRessource := WahrscheinlichkeitSchleifenwert;
                        
                  elsif
                    GezogeneZahlen (WahrscheinlichkeitSchleifenwert) = GezogeneZahlen (WelcheRessource)
                    and
                      ZufallsgeneratorenKarten.KartengeneratorBoolean = True
                  then
                     WelcheRessource := WahrscheinlichkeitSchleifenwert;
                           
                  else
                     null;
                  end if;
            end case;
         end if;
         
      end loop WahrscheinlichkeitSchleife;
      
      case
        WelcheRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return;
              
         when others =>
            WelcheRessource := RessourceZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                            RessourceExtern   => WelcheRessource);
      end case;
      
      case
        WelcheRessource
      is
         when KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum'Range =>
            SchreibeKarten.Ressource (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                      RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorRessourcenOberflächeLand;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Kohle_Enum =>
            return ZusatzberechnungKohle (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Eisen_Enum =>
            return ZusatzberechnungEisen (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Öl_Enum =>
            return ZusatzberechnungÖl (KoordinatenExtern => KoordinatenExtern,
                                        RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Hochwertiger_Boden_Enum =>
            return ZusatzberechnungHochwertigerBoden (KoordinatenExtern => KoordinatenExtern,
                                                      RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Gold_Enum =>
            return ZusatzberechnungGold (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => RessourceExtern);
      end case;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungKohle;
   
   
   
   function ZusatzberechnungEisen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungEisen;
   
   
   
   function ZusatzberechnungÖl
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungÖl;
   
   
   
   function ZusatzberechnungHochwertigerBoden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungHochwertigerBoden;
   
   
   
   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungGold;

end KartengeneratorRessourcenOberflaecheLand;
