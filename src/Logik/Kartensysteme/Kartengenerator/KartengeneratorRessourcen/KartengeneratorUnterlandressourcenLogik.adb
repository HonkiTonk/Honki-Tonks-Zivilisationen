with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorUnterlandressourcenLogik is

   procedure KartengeneratorUnterlandressourcen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      WelcheRessource := KartengrundDatentypen.Leer_Ressource_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > KartengeneratorVariablenLogik.KartenressourcenWahrscheinlichkeiten (ZufallszahlSchleifenwert)
           or
             GezogeneZahl = 0
         then
            null;
            
         elsif
           (GezogeneZahl = Zahlenspeicher
            and
              ZufallsgeneratorenKartenLogik.KartengeneratorBoolean = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcheRessource := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
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
         when KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum'Range =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                      RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorUnterlandressourcen;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Unterfläche_Land_Enum)
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

end KartengeneratorUnterlandressourcenLogik;
