pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;
with Warnung;

package body KartengeneratorRessourcenOberflaecheLand is

   procedure KartengeneratorRessourcenOberflächeLand
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
      
      SchreibeKarten.Ressource (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                RessourceExtern   => WelcheRessource);
      
   end KartengeneratorRessourcenOberflächeLand;
   
   
   
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
            
         when KartengrundDatentypen.Kohle_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungKohle (YAchseExtern    => YAchseExtern,
                                                                  XAchseExtern    => XAchseExtern,
                                                                  RessourceExtern => RessourceExtern);
            
         when KartengrundDatentypen.Eisen_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungEisen (YAchseExtern    => YAchseExtern,
                                                                  XAchseExtern    => XAchseExtern,
                                                                  RessourceExtern => RessourceExtern);
            
         when KartengrundDatentypen.Öl_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungÖl (YAchseExtern    => YAchseExtern,
                                                                XAchseExtern    => XAchseExtern,
                                                                RessourceExtern => RessourceExtern);
            
         when KartengrundDatentypen.Hochwertiger_Boden_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungHochwertigerBoden (YAchseExtern    => YAchseExtern,
                                                                              XAchseExtern    => XAchseExtern,
                                                                              RessourceExtern => RessourceExtern);
            
         when KartengrundDatentypen.Gold_Enum =>
            ZusatzberechnungenRessource := ZusatzberechnungGold (YAchseExtern    => YAchseExtern,
                                                                 XAchseExtern    => XAchseExtern,
                                                                 RessourceExtern => RessourceExtern);
            
         when others =>
            Warnung.LogikWarnung (WarnmeldungExtern => "KartengeneratorRessourcenOberflaecheLand.RessourceZusatzberechnungen - Ressourcenart passt nicht zum Grund.");
            ZusatzberechnungenRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      end case;
      
      return ZusatzberechnungenRessource;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungKohle
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
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
      
   end ZusatzberechnungKohle;
   
   
   
   function ZusatzberechnungEisen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
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
      
   end ZusatzberechnungEisen;
   
   
   
   function ZusatzberechnungÖl
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
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
      
   end ZusatzberechnungÖl;
   
   
   
   function ZusatzberechnungHochwertigerBoden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
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
      
   end ZusatzberechnungHochwertigerBoden;
   
   
   
   function ZusatzberechnungGold
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
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
      
   end ZusatzberechnungGold;

end KartengeneratorRessourcenOberflaecheLand;
