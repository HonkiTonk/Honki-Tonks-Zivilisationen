pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;
with Warnung;

package body KartengeneratorRessourcenUnterflaecheWasser is

   procedure KartengeneratorRessourcenUnterflächeWasser
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
         
         GezogeneZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.ZufälligerWert;
         
      end loop ZufallszahlenSchleife;
      
      WelcheRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      WelcheMöglichkeiten := (others => False);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
         
         if
           GezogeneZahlen (AuswahlSchleifenwert) < KartenressourceWahrscheinlichkeit (AuswahlSchleifenwert)
         then
            WelcheMöglichkeiten (AuswahlSchleifenwert) := True;
            
         else
            null;
         end if;
         
      end loop AuswahlSchleife;
      
      ------------------- Braucht noch ein wenig Feinabstimmung.
      ErsteSchleife:
      for ErsterSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
         ZweiteSchleife:
         for ZweiterSchleifenwert in KartenressourceWahrscheinlichkeitArray'Range loop
            
            if
              WelcheMöglichkeiten (ErsterSchleifenwert) = False
              or
                WelcheMöglichkeiten (ZweiterSchleifenwert) = False
            then
               null;
               
            elsif
              GezogeneZahlen (ErsterSchleifenwert) >= GezogeneZahlen (ZweiterSchleifenwert)
            then
               WelcheRessource := ErsterSchleifenwert;
               
            else
               WelcheRessource := ZweiterSchleifenwert;
            end if;
            
         end loop ZweiteSchleife;
      end loop ErsteSchleife;
            
      WelcheRessource := RessourceZusatzberechnungen (YAchseExtern    => YAchseExtern,
                                                      XAchseExtern    => XAchseExtern,
                                                      RessourceExtern => WelcheRessource);
      
      SchreibeKarten.Ressource (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                                RessourceExtern   => WelcheRessource);
      
   end KartengeneratorRessourcenUnterflächeWasser;
   
   
   
   function RessourceZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Enum)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            ZusatzberechnungenRessource := RessourceExtern;
            
         when KartengrundDatentypen.Fisch_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungFisch (YAchseExtern    => YAchseExtern,
                                                                  XAchseExtern    => XAchseExtern,
                                                                  RessourceExtern => RessourceExtern);
            
         when KartengrundDatentypen.Wal_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungWal (YAchseExtern    => YAchseExtern,
                                                                XAchseExtern    => XAchseExtern,
                                                                RessourceExtern => RessourceExtern);
            
         when others =>
            Warnung.LogikWarnung (WarnmeldungExtern => "KartengeneratorRessourcenUnterflaecheWasser.RessourceZusatzberechnungen - Ressourcenart passt nicht zum Grund.");
            ZusatzberechnungenRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      end case;
      
      return ZusatzberechnungenRessource;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Wasser)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Wasser)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungWal;

end KartengeneratorRessourcenUnterflaecheWasser;
