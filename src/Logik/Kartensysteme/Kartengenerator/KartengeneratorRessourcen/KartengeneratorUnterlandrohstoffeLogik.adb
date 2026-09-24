with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenHTSEB;

package body KartengeneratorUnterlandrohstoffeLogik is

   procedure Unterlandrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            WelcherRohstoff := KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum;
            Zahlenspeicher := 0;
      
            ZufallszahlenSchleife:
            for ZufallszahlSchleifenwert in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum'Range loop
         
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
                  WelcherRohstoff := ZufallszahlSchleifenwert;
            
               else
                  null;
               end if;
         
            end loop ZufallszahlenSchleife;
      
            case
              WelcherRohstoff
            is
               when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
                  return;
              
               when others =>
                  WelcherRohstoff := RohstoffZusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                                 RohstoffeExtern   => WelcherRohstoff);
            end case;
      
            case
              WelcherRohstoff
            is
               when KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum'Range =>
                  SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                               RohstoffnummerExtern => RohstoffeSchleifenwert,
                                               RohstoffExtern       => WelcherRohstoff);
               
                  exit GenerierungSchleife;
            
               when others =>
                  null;
            end case;
         
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end Unterlandrohstoffe;
   
   
   
   function RohstoffZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
   is begin
      
      -- case
      --  RohstoffeExtern
      -- is
      --  when KartenrohstoffeDatentypen.Kohle_Enum =>
      --   return ZusatzberechnungKohle (KoordinatenExtern => KoordinatenExtern,
      --                               RohstoffeExtern   => RohstoffeExtern);
            
      --  when KartenrohstoffeDatentypen.Eisen_Enum =>
      --   return ZusatzberechnungEisen (KoordinatenExtern => KoordinatenExtern,
      --                               RohstoffeExtern   => RohstoffeExtern);
            
      --  when KartenrohstoffeDatentypen.Öl_Enum =>
      --   return ZusatzberechnungÖl (KoordinatenExtern => KoordinatenExtern,
      --                             RohstoffeExtern   => RohstoffeExtern);
            
      -- when KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum =>
      --  return ZusatzberechnungHochwertigerBoden (KoordinatenExtern => KoordinatenExtern,
      --                                          RohstoffeExtern   => RohstoffeExtern);
            
      --  when KartenrohstoffeDatentypen.Gold_Enum =>
      return ZusatzberechnungGold (KoordinatenExtern => KoordinatenExtern,
                                   RohstoffeExtern   => RohstoffeExtern);
      -- end case;
      
   end RohstoffZusatzberechnungen;
   
   
   
   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
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
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
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
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
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
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
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
   
   
   
   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
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

end KartengeneratorUnterlandrohstoffeLogik;
