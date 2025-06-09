with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenHTSEB;

package body KartengeneratorWasserressourcenLogik is

   procedure KartengeneratorWasserressourcen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      WelcheRessource := KartenextraDatentypen.Leer_Ressource_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum'Range loop
         
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
              ZufallsgeneratorenHTSEB.Münzwurf = True)
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
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return;
              
         when others =>
            WelcheRessource := RessourceZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                            RessourceExtern   => WelcheRessource);
      end case;
      
      case
        WelcheRessource
      is
         when KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum'Range =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                         RessourceExtern   => WelcheRessource);
            
         when others =>
            null;
      end case;
            
   end KartengeneratorWasserressourcen;
   
   
   
   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        RessourceExtern
      is            
         when KartenextraDatentypen.Fisch_Enum =>
            return ZusatzberechnungFisch (KoordinatenExtern => KoordinatenExtern,
                                          RessourceExtern   => RessourceExtern);
            
         when KartenextraDatentypen.Wal_Enum =>
            return ZusatzberechnungWal (KoordinatenExtern => KoordinatenExtern,
                                        RessourceExtern   => RessourceExtern);
      end case;
      
   end RessourceZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RessourceExtern;
      
   end ZusatzberechnungWal;

end KartengeneratorWasserressourcenLogik;
