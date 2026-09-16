with ZufallsgeneratorenHTSEB;

with KartenzusatzgrundDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorLandrohstoffeLogik is

   procedure KartengeneratorLandrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      WelcheRohstoff := KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           KartengeneratorVariablenLogik.RohstoffwahrscheinlichkeitenLesen (RohstoffeExtern => ZufallszahlSchleifenwert) = 100
         then
            Zahlenspeicher := GezogeneZahl;
            WelcheRohstoff := ZufallszahlSchleifenwert;
            
         elsif
           GezogeneZahl > KartengeneratorVariablenLogik.RohstoffwahrscheinlichkeitenLesen (RohstoffeExtern => ZufallszahlSchleifenwert)
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
            WelcheRohstoff := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      -- Sollte bei den Rohstoffe nicht eher eine erneute Prüfung erfolgen wenn keine Rohstoffe gewählt wurde? äöü
      -- Eventuell wenn bereits eine Rohstoffe sich um dieses Feld herumbefindet? äöü
      -- Oder bei einem bestimmten Grund, beziehungsweise dessen Häufigkeit um die Rohstoffe herum? äöü
      case
        WelcheRohstoff
      is
         when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
            return;
              
         when others =>
            WelcheRohstoff := RohstoffZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                          RohstoffeExtern   => WelcheRohstoff);
      end case;
      
      case
        WelcheRohstoff
      is
         when KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum'Range =>
            SchreibeWeltkarte.Rohstoff (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                        RohstoffeExtern   => WelcheRohstoff);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorLandrohstoffe;
   
   
   
   function RohstoffZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
     -- case
       -- RohstoffeExtern
     -- is
       --  when KartenrohstoffeDatentypen.Kohle_Enum =>
           -- return ZusatzberechnungKohle (KoordinatenExtern => KoordinatenExtern,
          --                                RohstoffeExtern   => RohstoffeExtern);
            
        -- when KartenrohstoffeDatentypen.Eisen_Enum =>
           -- return ZusatzberechnungEisen (KoordinatenExtern => KoordinatenExtern,
          --                                RohstoffeExtern   => RohstoffeExtern);
            
        -- when KartenrohstoffeDatentypen.Öl_Enum =>
           -- return ZusatzberechnungÖl (KoordinatenExtern => KoordinatenExtern,
         --                               RohstoffeExtern   => RohstoffeExtern);
            
       --  when KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum =>
           -- return ZusatzberechnungHochwertigerBoden (KoordinatenExtern => KoordinatenExtern,
          --                                            RohstoffeExtern   => RohstoffeExtern);
            
        -- when KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum =>
        --  return ZusatzberechnungHochwertigesHolz (KoordinatenExtern => KoordinatenExtern,
        --                                           RohstoffeExtern   => RohstoffeExtern);
            
      -- when KartenrohstoffeDatentypen.Gold_Enum =>
      return ZusatzberechnungGold (KoordinatenExtern => KoordinatenExtern,
                                   RohstoffeExtern    => RohstoffeExtern);
      -- end case;
      
   end RohstoffZusatzberechnungen;
   
   
   
   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffeExtern;
      
   end ZusatzberechnungKohle;
   
   
   
   function ZusatzberechnungEisen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffeExtern;
      
   end ZusatzberechnungEisen;
   
   
   
   function ZusatzberechnungÖl
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffeExtern;
      
   end ZusatzberechnungÖl;
   
   
   
   function ZusatzberechnungHochwertigerBoden
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffeExtern;
      
   end ZusatzberechnungHochwertigerBoden;
   
   
   
   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      case
        LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte))
      is
         when KartenzusatzgrundDatentypen.Wald_Enum | KartenzusatzgrundDatentypen.Dschungel_Enum =>
            return RohstoffeExtern;
            
         when others =>
            return KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum;
      end case;
      
   end ZusatzberechnungHochwertigesHolz;
   
   
   
   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffeExtern;
      
   end ZusatzberechnungGold;

end KartengeneratorLandrohstoffeLogik;
