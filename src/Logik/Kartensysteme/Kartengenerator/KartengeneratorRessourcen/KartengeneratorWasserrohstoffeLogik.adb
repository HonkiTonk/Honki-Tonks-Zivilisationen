with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenHTSEB;

package body KartengeneratorWasserrohstoffeLogik is

   procedure KartengeneratorWasserrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      WelcheRohstoff := KartenrohstoffeDatentypen.Leer_Rohstoff_Enum;
      Zahlenspeicher := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Wasser_Enum'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > KartengeneratorVariablenLogik.RohstoffwahrscheinlichkeitenLesen (RohstoffExtern => ZufallszahlSchleifenwert)
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
         when KartenrohstoffeDatentypen.Leer_Rohstoff_Enum =>
            return;
              
         when others =>
            WelcheRohstoff := RohstoffZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                            RohstoffExtern   => WelcheRohstoff);
      end case;
      
      case
        WelcheRohstoff
      is
         when KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Wasser_Enum'Range =>
            SchreibeWeltkarte.Rohstoff (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                         RohstoffExtern   => WelcheRohstoff);
            
         when others =>
            null;
      end case;
            
   end KartengeneratorWasserrohstoffe;
   
   
   
   function RohstoffZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Wasser_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      case
        RohstoffExtern
      is            
         when KartenrohstoffeDatentypen.Fisch_Enum =>
            return ZusatzberechnungFisch (KoordinatenExtern => KoordinatenExtern,
                                          RohstoffExtern   => RohstoffExtern);
            
         when KartenrohstoffeDatentypen.Wal_Enum =>
            return ZusatzberechnungWal (KoordinatenExtern => KoordinatenExtern,
                                        RohstoffExtern   => RohstoffExtern);
      end case;
      
   end RohstoffZusatzberechnungen;
   
   
   
   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Wasser_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffExtern;
      
   end ZusatzberechnungFisch;
   
   
   
   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Oberfläche_Wasser_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return RohstoffExtern;
      
   end ZusatzberechnungWal;

end KartengeneratorWasserrohstoffeLogik;
