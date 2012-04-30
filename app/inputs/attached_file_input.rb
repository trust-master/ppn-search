class AttachedFileInput < SimpleForm::Inputs::FileInput
  # This class exists to allow one to distinguish between file inputs for paperclip attachments and
  # others. Inputs of this class get a thumbnail
end