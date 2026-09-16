with SchreibeWeltkarte;
with LeseWeltkarte;
with KartenzusatzgrundDatentypen;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenHTSEB;

package body KartengeneratorUnterwasserrohstoffeLogik is

   procedure KartengeneratorUnterwasserrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      WelcheRohstoff := KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Wasser_Enum'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
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
         when KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Wasser_Enum'Range =>
            SchreibeWeltkarte.Rohstoff (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                        RohstoffeExtern   => WelcheRohstoff);
            
         when others =>
            null;
      end case;
      
   end KartengeneratorUnterwasserrohstoffe;
   
   
   
   function RohstoffZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Wasser_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      --  case
      --  RohstoffeExtern
      -- is
      --  when KartenrohstoffeDatentypen.Fisch_Enum =>
      --   return ZusatzberechnungFisch (KoordinatenExtern => KoordinatenExtern,
      --                               RohstoffeExtern   => RohstoffeExtern);
            
      -- when KartenrohstoffeDatentypen.Wal_Enum =>
      --  return ZusatzberechnungWal (KoordinatenExtern => KoordinatenExtern,
      --                            RohstoffeExtern   => RohstoffeExtern);
            
      -- when KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum =>
      return ZusatzberechnungHochwertigesHolz (KoordinatenExtern => KoordinatenExtern,
                                               RohstoffeExtern   => RohstoffeExtern);
      -- end case;
      
   end RohstoffZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Enum)
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
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Enum)
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
      
   end ZusatzberechnungWal;
   
   
   
   function ZusatzberechnungHochwertigesHolz
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      case
        LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte))
      is
         when KartenzusatzgrundDatentypen.Unterwald_Enum =>
            return RohstoffeExtern;
            
         when others =>
            return KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum;
      end case;
      
   end ZusatzberechnungHochwertigesHolz;

end KartengeneratorUnterwasserrohstoffeLogik;
