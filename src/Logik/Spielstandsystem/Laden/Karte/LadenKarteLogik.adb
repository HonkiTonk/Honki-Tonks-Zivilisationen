with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with LadenSichtbarkeitLogik;
with SpielstandAllgemeinesLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.SpeziesanzahlErmitteln (SpeichernLadenExtern => False);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            null;
      end case;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               if
                 False = LadenSichtbarkeitLogik.Sichtbarkeit (DateiLadenExtern        => DateiLadenExtern,
                                                              KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                              VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                              LadenPrüfenExtern       => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                             KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = Feldelemente (DateiLadenExtern  => DateiLadenExtern,
                                       KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                       LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               else
                  null;
               end if;
                                                            
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EbeneSchleife;
            
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;
   
   
   
   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
            
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Basisgrund := KartengrundDatentypen.Wolken_Enum;
            
         when KartenKonstanten.WeltraumKonstante =>
            Basisgrund := KartengrundDatentypen.Weltraum_Enum;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => Basisgrund);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.BasisgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundEinlesen;
   
   
   
   function Feldelemente
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      AktuellesFeldelement := 2**6;
      
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                              Stadt);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**5;
               
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Verbesserung);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                               VerbesserungExtern => Verbesserung);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**4;
      
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                               Weg);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Weg (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                      WegExtern         => Weg);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**3;
               
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                               Ressource);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Ressource (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                            RessourceExtern   => Ressource);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**2;
               
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                          Fluss);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Fluss (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                        FlussExtern       => Fluss);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**1;
          
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                             VorhandeneFeldeffekte);
         VorhandeneFeldelemente := VorhandeneFeldelemente - AktuellesFeldelement;
                  
         AktuellerFeldeffekt := 2**(KartenRecords.FeldeffektArray'Length - 1);
         
         FeldeffekteSchleife:
         for FeldeffekteSchleifenwert in reverse KartenRecords.FeldeffektArray'Range loop
                     
            if
              VorhandeneFeldeffekte >= AktuellerFeldeffekt
            then
               Feldeffekte (FeldeffekteSchleifenwert) := True;
               VorhandeneFeldeffekte := VorhandeneFeldeffekte - AktuellerFeldeffekt;
                        
            else
               Feldeffekte (FeldeffekteSchleifenwert) := False;
            end if;
                     
            AktuellerFeldeffekt := AktuellerFeldeffekt / 2;
                     
         end loop FeldeffekteSchleife;
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                  FeldeffekteExtern => Feldeffekte);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      AktuellesFeldelement := 2**0;
               
      if
        VorhandeneFeldelemente >= AktuellesFeldelement
      then
         KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                Zusatzgrund);
                  
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                              GrundExtern       => Zusatzgrund);
                        
            when False =>
               null;
         end case;
                  
      else
         null;
      end if;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.Feldelemente: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Feldelemente;

end LadenKarteLogik;
