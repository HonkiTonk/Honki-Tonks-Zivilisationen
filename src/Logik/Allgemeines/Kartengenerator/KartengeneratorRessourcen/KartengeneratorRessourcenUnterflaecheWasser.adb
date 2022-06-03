pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorRessourcenUnterflaecheWasser is

   procedure KartengeneratorRessourcenUnterflächeWasser
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
         when KartengrundDatentypen.Kartenressourcen_Unterfläche_Wasser_Enum'Range =>
            SchreibeKarten.Ressource (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                      RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorRessourcenUnterflächeWasser;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Fisch_Enum =>
            return ZusatzberechnungFisch (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartengrundDatentypen.Wal_Enum =>
            return ZusatzberechnungWal (KoordinatenExtern => KoordinatenExtern,
                                        RessourceExtern   => RessourceExtern);
      end case;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Enum)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Enum)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungWal;

end KartengeneratorRessourcenUnterflaecheWasser;
