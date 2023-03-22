with KartengrundDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with ZufallegeneratorenAllgemein;
with KartengeneratorVariablenLogik;

package body KartengeneratorLandressourcenLogik is

   procedure KartengeneratorLandressourcen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      WelcheRessource := KartenextraDatentypen.Leer_Ressource_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum'Range loop
         
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
              ZufallegeneratorenAllgemein.Münzwurf = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcheRessource := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      -- Sollte bei den Ressourcen nicht eher eine erneute Prüfung erfolgen wenn keine Ressource gewählt wurde? äöü
      -- Eventuell wenn bereits eine Ressource sich um dieses Feld herumbefindet? äöü
      -- Oder bei einem bestimmten Grund, bezihungsweise dessen Häufigkeit um die Ressource herum? äöü
      case
        WelcheRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return;
              
         when others =>
            WelcheRessource := RessourceZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                            RessourceExtern   => WelcheRessource);
      end case;
      
      case
        WelcheRessource
      is
         when KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum'Range =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                         RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorLandressourcen;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Kohle_Enum =>
            return ZusatzberechnungKohle (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Eisen_Enum =>
            return ZusatzberechnungEisen (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Öl_Enum =>
            return ZusatzberechnungÖl (KoordinatenExtern => KoordinatenExtern,
                                        RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Hochwertiger_Boden_Enum =>
            return ZusatzberechnungHochwertigerBoden (KoordinatenExtern => KoordinatenExtern,
                                                      RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Hochwertiges_Holz_Enum =>
            return ZusatzberechnungHochwertigesHolz (KoordinatenExtern => KoordinatenExtern,
                                                     RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Gold_Enum =>
            return ZusatzberechnungGold (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => RessourceExtern);
      end case;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
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
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
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
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
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
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
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
   
   
   
   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse))
      is
         when KartengrundDatentypen.Wald_Enum | KartengrundDatentypen.Dschungel_Enum =>
            return RessourceExtern;
            
         when others =>
            return KartenextraDatentypen.Leer_Ressource_Enum;
      end case;
      
   end ZusatzberechnungHochwertigesHolz;
   
   
   
   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
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

end KartengeneratorLandressourcenLogik;
