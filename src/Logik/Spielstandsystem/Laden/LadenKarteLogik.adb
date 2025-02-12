with Ada.Exceptions; use Ada.Exceptions;

with KartenKonstanten;
with SystemKonstanten;
with SpeziesDatentypen;
with SpeziesKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.FeldelementVorhanden;
   begin
      
      case
        LadenPrüfenExtern
      is
         when True =>
            KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                                Karteneinstellungen);
            
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                                Karteneinstellungen);
      end case;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               if
                 False = ZahlNachSichtbarkeit (DateiLadenExtern  => DateiLadenExtern,
                                               KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                               LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                             KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                     
               else
                  SystemDatentypen.FeldelementVorhanden'Read (Stream (File => DateiLadenExtern),
                                                              VorhandeneFeldelemente);
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.StadtVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                       Stadt);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.StadtVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                         BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.EinheitVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                             Einheit);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.EinheitVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern          => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                            EinheitSpeziesNummerExtern => (Einheit.Spezies, Einheit.Nummer),
                                                            EinheitentauschExtern      => False);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.VerbesserungVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                                 Verbesserung);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.VerbesserungVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                        VerbesserungExtern => Verbesserung);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.WegVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Weg);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.WegVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Weg (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                               WegExtern         => Weg);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.RessourcenVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Ressource);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.RessourcenVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Ressource (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                     RessourceExtern   => Ressource);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.FlussVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                   Fluss);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.FlussVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Fluss (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                 FlussExtern       => Fluss);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.FeldeffekteVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartenRecords.FeldeffektArray'Read (Stream (File => DateiLadenExtern),
                                                      Feldeffekte);
                  VorhandeneFeldelemente := VorhandeneFeldelemente - SystemKonstanten.FeldeffekteVorhanden;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                           FeldeffekteExtern => Feldeffekte);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
               
               if
                 Natural (VorhandeneFeldelemente) - Positive (SystemKonstanten.ZusatzgrundVorhanden) >= Natural (SystemKonstanten.NichtsVorhanden)
               then
                  KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                         Zusatzgrund);
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                       GrundExtern       => Zusatzgrund);
                        
                     when False =>
                        null;
                  end case;
                  
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden"
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;
   
   
   
   function ZahlNachSichtbarkeit
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypen.Sichtbarkeitszahl;
   begin
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         SystemDatentypen.Sichtbarkeitszahl'Read (Stream (File => DateiLadenExtern),
                                                  Sichtbarkeit);
         
         case
           LadenPrüfenExtern
         is
            when False =>
               null;
            
            when True =>
               SichtbarkeitSchleife:
               for SichtbarkeitSchleifenwert in reverse SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
               
                  Potenz := SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SichtbarkeitSchleifenwert) - SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert));
                  
                  if
                    Natural (Sichtbarkeit) - 2**Potenz >= 0
                  then
                     GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                     Sichtbarkeit := Sichtbarkeit - 2**Potenz;
            
                  else
                     GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := False;
                  end if;
         
               end loop SichtbarkeitSchleife;
         end case;
         
      end loop BereichSchleife;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.GesamteSichtbarkeit (KoordinatenExtern  => KoordinatenExtern,
                                                   SichtbarkeitExtern => GesamteSichtbarkeit);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.ZahlNachSichtbarkeit: Konnte nicht geladen werden"
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ZahlNachSichtbarkeit;
   
   
   
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.BasisgrundEinlesen: Konnte nicht geladen werden"
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundEinlesen;

end LadenKarteLogik;
