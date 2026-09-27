with KartenKonstanten;
with LadezeitenDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with UmwandlungenRecords;
with LadezeitenLogik;

package body KartengeneratorOberrohstoffeLogik is

   procedure Landrohstoffe
      (LadezeitbasisExtern : in SystemDatentypenHTSEB.LadezeitBasis)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. KartengeneratorVariablenLogik.KartengrößeLesen.Waagerechte loop
            
            -- Die beiden Generatoren in einen Zusammenfassen. äöü
            -- Sollte möglich sein mit einer einzelnen Boolean abfrage. äöü
            -- Oder doch nicht so einfach? äöü
            case
              KartengeneratorVariablenLogik.RohstoffMehrfachLesen
            is
               when True =>
                  RohstoffMehrfach (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
            
               when False =>
                  RohstoffEinmal (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Rohstoffe_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Landrohstoffe;
   
   
   
   procedure RohstoffMehrfach
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      VorhandenerGrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      VorhandenerFluss := LeseWeltkarte.Fluss (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            Rohstoff := ZufallsgeneratorenKartenLogik.KartengeneratorRohstoffe;
            
            if
              BasisgrundRohstoffe (VorhandenerGrund.Basisgrund, Rohstoff) = False
            then
               null;
              
            elsif
              ZusatzgrundRohstoffe (VorhandenerGrund.Zusatzgrund, Rohstoff) = False
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
            case
              FlussRohstoffe (VorhandenerFluss, Rohstoff)
            is
               when True =>
                  SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                               RohstoffnummerExtern => RohstoffeSchleifenwert,
                                               RohstoffExtern       => Rohstoff);
                  
                  exit GenerierungSchleife;
                  
               when False =>
                  null;
            end case;
                    
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end RohstoffMehrfach;
   
   
   
   procedure RohstoffEinmal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      VorhandenerGrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            Rohstoff := ZufallsgeneratorenKartenLogik.KartengeneratorRohstoffe;
            
            RohstoffEinzigartig := RohstoffeVergleichen (KoordinatenExtern => KoordinatenExtern,
                                                         RohstoffExtern    => Rohstoff);
            
            if
              RohstoffEinzigartig = False
            then
               null;
            
            elsif
              BasisgrundRohstoffe (VorhandenerGrund.Basisgrund, Rohstoff) = False
            then
               null;
              
            elsif
              ZusatzgrundRohstoffe (VorhandenerGrund.Zusatzgrund, Rohstoff) = False
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
            if
              RohstoffEinzigartig = False
            then
               null;
               
            elsif
              FlussRohstoffe (VorhandenerFluss, Rohstoff) = True
            then
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
                  
            else
               null;
            end if;
            
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end RohstoffEinmal;
   
   
   
   function RohstoffeVergleichen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean
   is
      use type KartenrohstoffeDatentypen.Rohstoffe_Enum;
   begin
      
      VergleichenSchleife:
      for VergleichenSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
                  
         if
           RohstoffExtern = LeseWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                                     RohstoffnummerExtern => VergleichenSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
               
      end loop VergleichenSchleife;
      
      return True;
      
   end RohstoffeVergleichen;

end KartengeneratorOberrohstoffeLogik;
