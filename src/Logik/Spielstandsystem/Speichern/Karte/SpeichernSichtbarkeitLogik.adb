with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with LeseWeltkarte;
with LeseSpeziesbelegung;

package body SpeichernSichtbarkeitLogik is
   
   procedure Leersetzung
   is begin
      
      SichtbarkeitGesamt := (others => (others => False));
      
   end Leersetzung;
   
   
   
   procedure Sichtbarkeitsbelegung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive)
   is begin
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         SichtbarkeitGesamt (SichtbarkeitSchleifenwert, FelderanzahlExtern) := LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                                                                                       SpeziesExtern     => SichtbarkeitSchleifenwert);
         
      end loop SichtbarkeitSchleife;
      
   end Sichtbarkeitsbelegung;
   
   
   
   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) not in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            null;
            
         elsif
           False = SichtbarkeitSchreiben (DateiSpeichernExtern => DateiSpeichernExtern,
                                          SichtbarkeitExtern   => SichtbarkeitGesamt,
                                          SpeziesExtern        => SpeziesSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end Aufteilung;
   
   
   
   function SichtbarkeitSchreiben
     (DateiSpeichernExtern : in File_Type;
      SichtbarkeitExtern : in SichtbarkeitGesamtArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SichtbarkeitVorhanden := 0;
      AktuelleSichtbarkeit := 1;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SichtbarkeitExtern'Range (2) loop
         
         case
           SichtbarkeitExtern (SpeziesExtern, SichtbarkeitSchleifenwert)
         is
            when True =>
               SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
            when False =>
               null;
         end case;
         
         AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
         
      end loop SichtbarkeitSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           SichtbarkeitVorhanden);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.SichtbarkeitSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitSchreiben;

end SpeichernSichtbarkeitLogik;
